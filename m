From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Jul 2016 13:36:44 +0200
Subject: [LTP] [PATCH] lib: add [SAFE_]FILE_LINES_SCANF
In-Reply-To: <ae355058af800fd8fbc410b839ce25a128ab4339.1468492135.git.jstancek@redhat.com>
References: <ae355058af800fd8fbc410b839ce25a128ab4339.1468492135.git.jstancek@redhat.com>
Message-ID: <20160718113644.GA18221@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  lib/tests/tst_safe_fileops.c    | 40 +++++++++++++++++++++++++++++++++++

The last minor nitpick is that the lib/tests/ directory is full of
oldlib tests and this is a newlib test. It may be better to add this
file to the lib/newlib_tests/.

Anyway this version looks fine, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
