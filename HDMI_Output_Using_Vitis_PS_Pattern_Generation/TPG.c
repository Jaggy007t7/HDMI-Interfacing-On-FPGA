// Corrected code:-
#include "xil_printf.h"
#include "xparameters.h"
#include "xstatus.h"
#include "xv_tpg.h"
#include "sleep.h"

XV_tpg Tpg;
int Status;

int main()
{
    xil_printf("\r\n===== SAFE TPG PATTERN TEST =====\r\n");

    Status = XV_tpg_Initialize(&Tpg, XPAR_V_TPG_0_BASEADDR);

    if (Status != XST_SUCCESS)
    {
        xil_printf("TPG Initialization Failed\r\n");
        return XST_FAILURE;
    }

    /* Configure resolution */
    XV_tpg_Set_width(&Tpg, 1920);
    XV_tpg_Set_height(&Tpg, 1080);
    XV_tpg_Set_colorFormat(&Tpg, 0);

    /* Start TPG */
    XV_tpg_EnableAutoRestart(&Tpg);
    XV_tpg_Start(&Tpg);

    xil_printf("TPG Started\r\n");

    while (1)
    {
        xil_printf("Pattern: COLOR BARS\r\n");
        XV_tpg_Set_bckgndId(&Tpg, XTPG_BKGND_COLOR_BARS);
        sleep(3);

        /* fallback numeric patterns (safe even if enum differs) */
        xil_printf("Pattern: ID 1\r\n");
        XV_tpg_Set_bckgndId(&Tpg, 1);
        sleep(3);

        xil_printf("Pattern: ID 2\r\n");
        XV_tpg_Set_bckgndId(&Tpg, 2);
        sleep(3);

        xil_printf("Pattern: ID 3\r\n");
        XV_tpg_Set_bckgndId(&Tpg, 3);
        sleep(3);
    }

    return XST_SUCCESS;
}
