From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 26 Apr 2021 13:01:06 +0100
Subject: [LTP] [PATCH 1/2] lapi/bpf: Add /= and %=
Message-ID: <20210426120107.6632-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add div and mod instructions.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
index f27a92146..5ae25293b 100644
--- a/include/lapi/bpf.h
+++ b/include/lapi/bpf.h
@@ -37,8 +37,10 @@
 #define BPF_OP(code)    ((code) & 0xf0)
 #define		BPF_ADD		0x00
 #define		BPF_SUB		0x10
+#define		BPF_DIV		0x30
 #define		BPF_LSH		0x60
 #define		BPF_RSH		0x70
+#define		BPF_MOD		0x90
 
 #define		BPF_JEQ		0x10
 
-- 
2.31.1

