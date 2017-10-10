From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Oct 2017 16:26:03 +0200
Subject: [LTP] [PATCH v2 1/1] syscalls/profil01: Fix build for libc
 without profil() support
In-Reply-To: <20171002133341.30855-1-pvorel@suse.cz>
References: <20171002133341.30855-1-pvorel@suse.cz>
Message-ID: <20171010142603.GA30675@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've fixed the patch and pushed, thanks.

I've added #include "config.h" so that the test is actually enabled when
configure finds that profil is implemented and also suffled the TCID
before the #ifdef so that it's defined for the TCONF branch as well.

-- 
Cyril Hrubis
chrubis@suse.cz
