// Veriables
#let uni_name = [
  *Politechnika Krakowska \
  im. Tadeusza Kościuszki*
]
#let faculty = [Wydział Informatyki i Telekomunikacji]
#let field = [INFORMATYKA]
#let specialization = [DATA SCIENCE]
#let title = [Zastosowanie sieci typu KAN w zagadnieniu 
kompresji #box[obrazu]]
#let title_ang = [Application of Kolmogorov-Arnold Networks in
Image Compression]
#let author = [Sylwester Wieczorek]
#let promotor = [dr inż. Dominika Cywicka]
#let opiekun = [dr Ilona Urbaniak]
#let year = [2025]
#let album = [140268]
#let pk_logo_path = "./images/pk-logo.png"
#let wit_logo_path = "./images/wit-logo.png"

#let theme_color = color.hsl(
  260deg, 82%, 92%
)

#let leading_size = 1.5em // [5] Should be 1.5em but I don't like it

// Helpers

#let round_floats_in_row = (row, dig: 4) => {
  row.map(x => {
    if regex("\d+\.\d+") in x {
      let fl = float(x)
      let str = str(calc.round(fl, digits: dig))
      while str.ends-with("0") and str.contains(".") { 
        str = str.slice(0, -1) 
      }
      if str.ends-with(".") { 
        str = str.slice(0, -1) 
      }
      str
    } else {
      x
    }
  })
}

#let note(body, note) = box(
    fill: luma(250),
    inset: 8pt,
    radius: 4pt,
    stroke: (dash: "dashed")
    )[
    #body,
    \
    #box(
      fill: rgb("#fff06d"),
      inset: 4pt,
      radius: 2pt,
      )[#note]
  ]

#let side-note(body, note) = grid(
    columns: (1fr, 100pt),
    )[
      #rect(width: 100%, stroke: none)[#body]
  ][
    #rect(
      width: 100%, 
      fill: rgb("#fff06d"))[#note]
  ]

#let fix(old, new, soft: false) = if soft {
    [#text(orange)[#strike[#old]] #text(rgb("#2e7c01"))[#new]]
} else {
    [#text(red)[#strike[#old]] #text(rgb("#2e7c01"))[#new]]
}

// Plots

#let epochs = (1,2,3,4,5,6,7,8,9,10)
#let metrics = (
  // ("train_mse", "MSE", "Train MSE"),
  ("val_mse",   "MSE", "MSE"),
  ("psnr",      "PSNR (dB)", "PSNR"),
  ("ssim",      "SSIM", "SSIM"),
)
#let print_plots(data, lq, title_ad: "") = {
  for (mkey, ylabel, title_small) in metrics {

    if mkey.contains("mse") {
      let plots = (lq.plot(epochs, data.cnn.at(mkey), label: "cnn", mark: "o"),
        lq.plot(epochs, data.kan_linear.at(mkey), label: "kan_linear", mark: "o"),
        lq.plot(epochs, data.kan_bezier.at(mkey), label: "kan_bezier", mark: "o"),
        lq.plot(epochs, data.kan_catmull.at(mkey), label: "kan_catmull", mark: "o"),
        lq.plot(epochs, data.kan_bspline.at(mkey), label: "kan_bspline", mark: "o"),
        lq.plot(epochs, data.fastkan.at(mkey), label: "fastkan", mark: "o"))
      lq.diagram(
        width: 360pt, height: 280pt,
        title: title_small + title_ad,
        xlabel: [Epoka], ylabel: ylabel,
        xaxis: (ticks: epochs, subticks: none),
        legend: (position: top + right),

        ..plots
      )
    } else {
      lq.diagram(
        width: 360pt, height: 280pt,
        title: title_small + title_ad,
        xlabel: [Epoka], ylabel: ylabel,
        xaxis: (ticks: epochs, subticks: none),
        legend: (position: top + left),

        lq.plot(epochs, data.cnn.at(mkey), label: "cnn", mark: "o"),
        lq.plot(epochs, data.kan_linear.at(mkey), label: "kan_linear", mark: "o"),
        lq.plot(epochs, data.kan_bezier.at(mkey), label: "kan_bezier", mark: "o"),
        lq.plot(epochs, data.kan_catmull.at(mkey), label: "kan_catmull", mark: "o"),
        lq.plot(epochs, data.kan_bspline.at(mkey), label: "kan_bspline", mark: "o"),
        lq.plot(epochs, data.fastkan.at(mkey), label: "fastkan", mark: "o")
      )
    }
    v(10pt)
  }
}

#let print_step_plots(data, lq, w: 6cm, h: 4cm, white_list: ("cnn","kan_linear","kan_bezier","kan_catmull","kan_bspline","fastkan")) = {
  for (mkey, ylabel, title_small) in metrics {
      let i = 0;
      let plots = for data_size in data {
        i += 1;
        (
          if white_list.contains("cnn") {
            lq.plot(
              epochs, 
              data_size.cnn.at(mkey), 
              stroke: if i == 1 {stroke(dash:"solid", thickness: 1.1pt)} else if i == 2 
              {stroke(dash:"dotted", thickness: 1.5pt)} else if i == 3
              {stroke(dash:"dashed", thickness: 1.5pt)} else if i == 4
              {stroke(dash:"dash-dotted")} else 
              {stroke(dash:"densely-dashed")},
              label: if i == 1 {"Cnn"} else {}, 
              mark: "o", 
              color: color.hsl(
                0deg,  
                255, 
                50%,
                100%,
                )
              )
          },
          if white_list.contains("kan_linear") {
            lq.plot(
              epochs, 
              data_size.kan_linear.at(mkey), 
              stroke: if i == 1 {stroke(dash:"solid", thickness: 1.1pt)} else if i == 2 
              {stroke(dash:"dotted", thickness: 1.5pt)} else if i == 3
              {stroke(dash:"dashed", thickness: 1.5pt)} else if i == 4
              {stroke(dash:"dash-dotted")} else 
              {stroke(dash:"densely-dashed")},
              label: if i == 1 {"Kan linear"} else {}, 
              mark: "s", 
              color: color.hsl(150deg, 100%, 27.06%))
          },
          if white_list.contains("kan_bezier") {
            lq.plot(
              epochs, 
              data_size.kan_bezier.at(mkey), 
              stroke: if i == 1 {stroke(dash:"solid", thickness: 1.1pt)} else if i == 2 
              {stroke(dash:"dotted", thickness: 1.5pt)} else if i == 3
              {stroke(dash:"dashed", thickness: 1.5pt)} else if i == 4
              {stroke(dash:"dash-dotted")} else 
              {stroke(dash:"densely-dashed")},
              label: if i == 1 {"Kan bezier"} else {}, 
              mark: "x", 
              color: color.hsl(
                100deg,  
                255, 
                50%,
                100%,
                ))
          },
          if white_list.contains("kan_catmull") {
            lq.plot(
              epochs, 
              data_size.kan_catmull.at(mkey), 
              stroke: if i == 1 {stroke(dash:"solid", thickness: 1.1pt)} else if i == 2 
              {stroke(dash:"dotted", thickness: 1.5pt)} else if i == 3
              {stroke(dash:"dashed", thickness: 1.5pt)} else if i == 4
              {stroke(dash:"dash-dotted")} else 
              {stroke(dash:"densely-dashed")},
              label: if i == 1 {"Kan catmull"} else {}, 
              mark: "s3", 
              color: color.hsl(
                55deg,  
                255, 
                70%,
                100%,
                ))
          },
          if white_list.contains("kan_bspline") {
            lq.plot(
              epochs, 
              data_size.kan_bspline.at(mkey), 
              stroke: if i == 1 {stroke(dash:"solid", thickness: 1.1pt)} else if i == 2 
              {stroke(dash:"dotted", thickness: 1.5pt)} else if i == 3
              {stroke(dash:"dashed", thickness: 1.5pt)} else if i == 4
              {stroke(dash:"dash-dotted")} else 
              {stroke(dash:"densely-dashed")},
              label: if i == 1 {"Kan bspline"} else {}, 
              mark: "p5", 
              color: color.hsl(
                200deg,  
                255, 
                50%,
                100%,
                ))
          },
          if white_list.contains("fastkan") {
            lq.plot(
              epochs, 
              data_size.fastkan.at(mkey), 
              stroke: if i == 1 {stroke(dash:"solid", thickness: 1.1pt)} else if i == 2 
              {stroke(dash:"dotted", thickness: 1.5pt)} else if i == 3
              {stroke(dash:"dashed", thickness: 1.5pt)} else if i == 4
              {stroke(dash:"dash-dotted")} else 
              {stroke(dash:"densely-dashed")},
              label: if i == 1 {"Fastkan"} else {}, 
              mark: "^", 
              color: color.hsl(
                250deg, 
                255, 
                50%,
                100%,
                ))
          },
        )
      }
      
    if mkey.contains("mse") {
      lq.diagram(
        width: w, 
        height: h,
        title: title_small,
        xlabel: [Epoka], ylabel: ylabel,
        xaxis: (ticks: epochs, subticks: none),
        legend: (position: top + right),

        ..plots
      )
    } else {
      lq.diagram(
        width: w,
        height: h,
        title: title_small,
        xlabel: [Epoka], ylabel: ylabel,
        xaxis: (ticks: epochs, subticks: none),
        legend: (position: top + left),

        ..plots
      )
    }
  }
}