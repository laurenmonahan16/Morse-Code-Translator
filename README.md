# VGA Synchronization Project

This project implements synchronization signals for a VGA display controller. It generates horizontal (`h_sync`) and vertical (`v_sync`) synchronization pulses based on the current pixel position and timing parameters. These signals are essential for ensuring proper display of frames on a monitor.

---

## **Features**

- **Horizontal Sync (h_sync):**
  - Controls the timing of individual lines in the frame.
  - Activates during the horizontal blanking period.
- **Vertical Sync (v_sync):**
  - Controls the timing of frames.
  - Activates during the vertical blanking period.
- Fully parameterized to support customizable resolutions and refresh rates.

---

## **Code Overview**

### Synchronization Logic
The primary synchronization logic is implemented as follows:

```verilog
always @(posedge clk) begin
    h_sync <= (widthPos < H_SYNC_COLUMN) ? 1'b1 : 1'b0;
    v_sync <= (heightPos < V_SYNC_LINE) ? 1'b1 : 1'b0;
end
```

- `h_sync` is high (`1`) during the horizontal sync pulse and low (`0`) otherwise.
- `v_sync` is high (`1`) during the vertical sync pulse and low (`0`) otherwise.

### Inputs and Outputs
#### **Inputs**
- `clk`: Clock signal for synchronization.
- `widthPos`: Horizontal pixel position.
- `heightPos`: Vertical pixel position.

#### **Outputs**
- `h_sync`: Horizontal sync signal.
- `v_sync`: Vertical sync signal.

### Parameters
- `H_SYNC_COLUMN`: Specifies the width (in pixels) of the horizontal sync pulse.
- `V_SYNC_LINE`: Specifies the height (in lines) of the vertical sync pulse.

---

## **Getting Started**

### Prerequisites
- A Verilog simulator or FPGA development environment (e.g., ModelSim, Vivado, Quartus).
- Basic knowledge of VGA timing standards.

### Running the Project
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/vga-synchronization.git
   ```
2. Open the Verilog file in your preferred simulator or IDE.
3. Simulate the design to verify the behavior of the `h_sync` and `v_sync` signals.
4. Optionally, implement the design on an FPGA to drive a VGA display.

---

## **Customization**
- Modify the `H_SYNC_COLUMN` and `V_SYNC_LINE` parameters to support different resolutions.
- Integrate this module with a pixel generator to produce visual content.

---

## **Applications**
- VGA controllers for FPGA projects.
- Generating timing signals for custom display systems.
- Understanding display synchronization concepts.

---

## **References**
- [VGA Timing Standards (Wikipedia)](https://en.wikipedia.org/wiki/VGA)
- [FPGA4Fun: VGA in FPGA](https://www.fpga4fun.com/VGA.html)

---

## **License**
This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## **Contributing**
Contributions are welcome! If you have suggestions or improvements, feel free to submit a pull request.

---

## **Contact**
For any questions or feedback, please contact:
- **Name:** Your Name
- **Email:** your.email@example.com
- **GitHub:** [yourusername](https://github.com/yourusername)

