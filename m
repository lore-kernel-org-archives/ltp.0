From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 17 Aug 2018 18:43:13 +0300
Subject: [LTP] [PATCH] device-drivers/acpi: skip certain tests for
	HW-reduced ACPI
Message-ID: <1534520593-14253-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The "4.1 Hardware-Reduced ACPI" of the ACPI specification
details that for Hardware-reduced platforms the ACPI Fixed Hardware
interface is not implemented, so related test cases fail.
To avoid that, we skip these test cases if HW-reduced mode is detected.

One example of such systems is the aarch64 server platform.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../kernel/device-drivers/acpi/ltp_acpi_cmds.c     |   25 +++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c b/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
index 6e8f051..2733753 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c
@@ -231,14 +231,25 @@ static int acpi_traverse_from_root(void)
 
 /* first found device with _STR */
 static acpi_handle dev_handle;
+static int acpi_hw_reduced;
 
 static int acpi_init(void)
 {
 	acpi_status status;
 	acpi_handle parent_handle;
-
+	struct acpi_table_fadt *fadt;
+	struct acpi_table_header *table;
 	struct acpi_device_info *dev_info;
 
+	status = acpi_get_table(ACPI_SIG_FADT, 0, &table);
+	if (ACPI_SUCCESS(status)) {
+		fadt = (struct acpi_table_fadt *)table;
+		if (fadt->flags & ACPI_FADT_HW_REDUCED)
+			acpi_hw_reduced = 1;
+	}
+	if (acpi_hw_reduced)
+		prk_alert("Detected the Hardware-reduced ACPI mode");
+
 	prk_alert("TEST -- acpi_get_handle ");
 	status = acpi_get_handle(NULL, "\\_SB", &parent_handle);
 	if (acpi_failure(status, "acpi_get_handle"))
@@ -312,6 +323,10 @@ static int acpi_test_event_handler(void)
 	acpi_status status;
 
 	prk_alert("TEST -- acpi_install_fixed_event_handler");
+	if (acpi_hw_reduced) {
+		prk_alert("Skipped due to the HW-reduced mode");
+		return 0;
+	}
 	status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 		ltp_test_power_button_ev_handler, NULL);
 
@@ -352,6 +367,10 @@ static int acpi_global_lock(void)
 	u32 global_lock = 0;
 
 	prk_alert("TEST -- acpi_acquire_global_lock ");
+	if (acpi_hw_reduced) {
+		prk_alert("Skipped due to the HW-reduced mode");
+		return 0;
+	}
 	status = acpi_acquire_global_lock(ACPI_EC_UDELAY_GLK, &global_lock);
 	if (acpi_failure(status, "acpi_acquire_global_lock"))
 		return 1;
@@ -448,6 +467,10 @@ static int acpi_test_register(void)
 	acpi_status status;
 
 	prk_alert("TEST -- acpi_read_bit_register");
+	if (acpi_hw_reduced) {
+		prk_alert("Skipped due to the HW-reduced mode");
+		return 0;
+	}
 	/*
 	 * ACPICA: Remove obsolete Flags parameter.
 	 * http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;
-- 
1.7.1

