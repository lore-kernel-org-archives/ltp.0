From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Nov 2020 14:11:39 +0100
Subject: [LTP] [PATCH v2 00/11] 	Test metadata extraction
In-Reply-To: <20201103191327.11081-1-pvorel@suse.cz>
References: <20201103191327.11081-1-pvorel@suse.cz>
Message-ID: <20201112131139.GA4962@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> address some of the notes added by Li.

> changes v1->v2:

> 3rd commit
> https://patchwork.ozlabs.org/project/ltp/patch/20201005133054.23587-4-chrubis@suse.cz/
> * add buf[i++] = c; to fix parsing ""
> * check fname is valid before opening it
> * fix some of checkpatch.pl problems

> 9th commit
> * add perl-libwww-perl for fedora/centos

> 11 th commit
> * add *.css *.js to CLEAN_TARGETS

> TODO
> * I didn't filter "options". But agree they should be handled better than now.
> * some checkpatch.pl warnings left, do we want to bother?
> docparse/docparse.c:53: WARNING: Missing a blank line after declarations
> docparse/docparse.c:206: ERROR: do not use assignment in if condition
> docparse/docparse.c:211: WARNING: Missing a blank line after declarations
> docparse/docparse.c:246: ERROR: do not use assignment in if condition
> docparse/docparse.c:288: WARNING: Missing a blank line after declarations
> docparse/docparse.c:297: WARNING: static const char * array should probably be static const char * const
> docparse/docparse.c:352: WARNING: static const char * array should probably be static const char * const
> total: 2 errors, 5 warnings, 423 lines checked

> * I didn't change docparse/README.md (4th commit, Jan had some notes,
> could you phrase what should be there?)

> Anything else to change?

Anybody against pushing whole patchset [1] with fix below for third commit
("docparse: Add test documentation parser").


Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=211956&state=*

Fix for third commit:

diff --git docparse/docparse.c docparse/docparse.c
index 63d131c87..be6125353 100644
--- docparse/docparse.c
+++ docparse/docparse.c
@@ -138,10 +138,8 @@ const char *next_token(FILE *f, struct data_node *doc)
 
 		if (in_str) {
 			if (c == '"') {
-				if (i == 0 || buf[i-1] != '\\') {
-					buf[i++] = c;
+				if (i == 0 || buf[i-1] != '\\')
 					goto exit;
-				}
 			}
 
 			buf[i++] = c;
@@ -189,7 +187,7 @@ const char *next_token(FILE *f, struct data_node *doc)
 	}
 
 exit:
-	if (i == 0)
+	if (i == 0 && !in_str)
 		return NULL;
 
 	buf[i] = 0;
