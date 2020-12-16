From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Dec 2020 11:10:09 +0100
Subject: [LTP] [PATCH 2/5] doc_parse/data_storage: Bump the array max size
In-Reply-To: <20201216101012.14644-1-chrubis@suse.cz>
References: <20201216101012.14644-1-chrubis@suse.cz>
Message-ID: <20201216101012.14644-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Bump the array size to 100 from 20 for now. I will rewrite the code to
reallocate the array if needed later on.

At least now we won't have longer description comments cut in half.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 docparse/data_storage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docparse/data_storage.h b/docparse/data_storage.h
index 1a9265f92..ef420c08f 100644
--- a/docparse/data_storage.h
+++ b/docparse/data_storage.h
@@ -64,7 +64,7 @@ static inline struct data_node *data_node_string(const char *string)
 	return node;
 }
 
-#define MAX_ELEMS 20
+#define MAX_ELEMS 100
 
 static inline struct data_node *data_node_hash(void)
 {
-- 
2.26.2

