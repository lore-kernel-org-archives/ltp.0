From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Apr 2017 14:48:35 +0200
Subject: [LTP] [PATCH v3] lseek: functional SEEK_HOLE and SEEK_DATA test
In-Reply-To: <1491662411-7720-1-git-send-email-zlang@redhat.com>
References: <1491662411-7720-1-git-send-email-zlang@redhat.com>
Message-ID: <20170411124835.GA3738@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

I've added a lapi/seek.h header with fallback defintion for
SEEK_DATA and SEEK_HOLE, dropped the ifdefs from the test, and added a
a check if SEEK_HOLE is implemented to the test setup() function.

And also removed a few backslashes from the tst_res(... lines since
these are not needed at all.

-- 
Cyril Hrubis
chrubis@suse.cz
