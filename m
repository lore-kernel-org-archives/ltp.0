From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Sep 2017 17:58:02 +0200
Subject: [LTP] keyctl tests failing with EDQUOT
Message-ID: <20170926155802.GG4884@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've found another problem while doing pre-release testing.

The keyctl03 and sometimes keyctl05 fails with EDQUOT when executed
right after keyctl02 which creates and revokes keys in the loop and also
adjusts the quota temporarily. It fails for me on kernel 3.16 inside of
a qemu virtual machine. Looks like the keys are not deleted after the
keyctl02 test exits. Have anybody seen a failure like this one?

-- 
Cyril Hrubis
chrubis@suse.cz
