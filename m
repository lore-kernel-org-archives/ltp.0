From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 3 Mar 2021 12:30:13 +0800
Subject: [LTP] [PATCH 2/3] docparse/docparse.c: Add missing entries into
 struct implies
In-Reply-To: <20210303043014.484426-1-yangx.jy@cn.fujitsu.com>
References: <20210303043014.484426-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20210303043014.484426-2-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

needs_checkpoints and resource_files imply needs_tmpdir.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 docparse/docparse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docparse/docparse.c b/docparse/docparse.c
index 5879a9944..790c84a84 100644
--- a/docparse/docparse.c
+++ b/docparse/docparse.c
@@ -370,6 +370,8 @@ static struct implies {
 	{"all_filesystems", (const char *[]) {"needs_device", "needs_tmpdir",
 		NULL}},
 	{"needs_device", (const char *[]) {"needs_tmpdir", NULL}},
+	{"needs_checkpoints", (const char *[]) {"needs_tmpdir", NULL}},
+	{"resource_files", (const char *[]) {"needs_tmpdir", NULL}},
 	{NULL, (const char *[]) {NULL}}
 };
 
-- 
2.25.1



