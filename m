From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 17:08:30 +0100
Subject: [LTP] [PATCH v4 1/2] lib: add .request_hugepages to reserve
 hugepage
In-Reply-To: <20200208092014.24824-1-liwang@redhat.com>
References: <20200208092014.24824-1-liwang@redhat.com>
Message-ID: <20200217160830.GA6482@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Code looks good.
Minor issue: doc has broken formatting.

> +2.2.34 Reserving hugepages
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Many of the ltp tests need to use hugepage in their testing, this allows the
> +test can reserve hugepages from system only via .request_hugepages = xx.
> +
> +If set non-zero number of request_hugepages, test will try to reserve the
> +expected number of hugepage for testing in setup phase. If system does not
> +have enough hpage for using, it will try the best to reserve 80% available
> +number of hpages. With success test stores the reserved hugepage number in
> +'tst_hugepages. For the system without hugetlb supporting, variable
Missing ' here   ^

> +'tst_hugepages' will be set to 0.

I propose these changes (+ strip this formatting from comments in C source - include/tst_test.h).

Kind regards,
Petr

diff --git doc/test-writing-guidelines.txt doc/test-writing-guidelines.txt
index b9f8d5ab0..ae9a8b040 100644
--- doc/test-writing-guidelines.txt
+++ doc/test-writing-guidelines.txt
@@ -1945,14 +1945,14 @@ For full documentation see the comments in 'include/tst_fuzzy_sync.h'.
 2.2.34 Reserving hugepages
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Many of the ltp tests need to use hugepage in their testing, this allows the
-test can reserve hugepages from system only via .request_hugepages = xx.
+Many of the LTP tests need to use hugepage in their testing, this allows the
+test can reserve hugepages from system only via '.request_hugepages = xx'.
 
-If set non-zero number of request_hugepages, test will try to reserve the
+If set non-zero number of 'request_hugepages', test will try to reserve the
 expected number of hugepage for testing in setup phase. If system does not
 have enough hpage for using, it will try the best to reserve 80% available
 number of hpages. With success test stores the reserved hugepage number in
-'tst_hugepages. For the system without hugetlb supporting, variable
+'tst_hugepages'. For the system without hugetlb supporting, variable
 'tst_hugepages' will be set to 0.
 
 Also, we do cleanup and restore work for the hpages resetting automatically.
@@ -1977,9 +1977,12 @@ struct tst_test test = {
 	.request_hugepages = 2,
 	...
 };
+[source,c]
+-------------------------------------------------------------------------------
 
 or,
 
+-------------------------------------------------------------------------------
 #include "tst_test.h"
 
 static void run(void)
