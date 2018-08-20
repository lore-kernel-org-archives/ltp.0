From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Date: Mon, 20 Aug 2018 15:49:13 -0400
Subject: [LTP] [PATCH 3/5] acpi_hotplug: Add ACPIHOTPLUG_01.sh under runtest
In-Reply-To: <20180820194915.11805-1-msys.mizuma@gmail.com>
References: <20180820194915.11805-1-msys.mizuma@gmail.com>
Message-ID: <20180820194915.11805-4-msys.mizuma@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Add ACPI based hotplug test, ACPIHOTPLUG_01.sh under runtest directory.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 runtest/acpi_hotplug | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 runtest/acpi_hotplug

diff --git a/runtest/acpi_hotplug b/runtest/acpi_hotplug
new file mode 100644
index 000000000..9c6ccd3ad
--- /dev/null
+++ b/runtest/acpi_hotplug
@@ -0,0 +1 @@
+ACPIHOTPLUG_01 ACPIHOTPLUG_01.sh
-- 
2.18.0

