From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Apr 2021 14:30:04 +0200
Subject: [LTP] [PATCH 2/3] test: Adding timeout03.sh for testing
 _tst_kill_test()
In-Reply-To: <20210312173201.27708-3-pvorel@suse.cz>
References: <20210312173201.27708-1-pvorel@suse.cz>
 <20210312173201.27708-3-pvorel@suse.cz>
Message-ID: <YG2lzCHAcDvPMbpN@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looks obviously fine, but we have to update the expected output if we
are going to change the SIGTERM to SIGINT in the library.

Apart from that Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
