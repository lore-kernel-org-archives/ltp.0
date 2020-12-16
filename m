From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Dec 2020 11:10:10 +0100
Subject: [LTP] [PATCH 3/5] docparse/docparse: Eat only first whitespace for
 comment block
In-Reply-To: <20201216101012.14644-1-chrubis@suse.cz>
References: <20201216101012.14644-1-chrubis@suse.cz>
Message-ID: <20201216101012.14644-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since we decided that the comment block is formatted in asciidoc we need
the whitespaces since they are part of the format, e.g. literal blocks.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 docparse/docparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docparse/docparse.c b/docparse/docparse.c
index 702820757..9f617c8bb 100644
--- a/docparse/docparse.c
+++ b/docparse/docparse.c
@@ -31,7 +31,7 @@ static const char *eat_asterisk_space(const char *c)
 		i++;
 
 	if (c[i] == '*') {
-		while (isspace(c[i+1]))
+		if (isspace(c[i+1]))
 			i++;
 		return &c[i+1];
 	}
-- 
2.26.2

