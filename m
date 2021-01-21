From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jan 2021 14:00:32 +0100
Subject: [LTP] [PATCH 1/2] docparse: Replace \t with space
Message-ID: <20210121130033.20764-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to avoid constant failures because tabs are forbidden in JSON.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

Currently required for "Convert CAN tests to new LTP API" patchset
https://patchwork.ozlabs.org/project/ltp/patch/20210120143723.26483-5-rpalethorpe@suse.com/
https://patchwork.ozlabs.org/project/ltp/patch/20210120143723.26483-6-rpalethorpe@suse.com/

Kind regards,
Petr

 docparse/data_storage.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docparse/data_storage.h b/docparse/data_storage.h
index ef420c08f..99c2514b7 100644
--- a/docparse/data_storage.h
+++ b/docparse/data_storage.h
@@ -54,6 +54,7 @@ static inline struct data_node *data_node_string(const char *string)
 {
 	size_t size = sizeof(struct data_node_string) + strlen(string) + 1;
 	struct data_node *node = malloc(size);
+	char *ix = node->string.val;
 
 	if (!node)
 		return NULL;
@@ -61,6 +62,9 @@ static inline struct data_node *data_node_string(const char *string)
 	node->type = DATA_STRING;
 	strcpy(node->string.val, string);
 
+	while ((ix = strchr(ix, '\t')))
+		*ix++ = ' ';
+
 	return node;
 }
 
-- 
2.30.0

