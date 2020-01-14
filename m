From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Jan 2020 14:27:45 +0100
Subject: [LTP] [PATCH v4] Use real FS block size in fallocate05
In-Reply-To: <20200113142424.25663-1-mdoucha@suse.cz>
References: <20200113142424.25663-1-mdoucha@suse.cz>
Message-ID: <20200114132744.GA10869@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

I've added ack from Jan that was for v3 since the changes were mostly
cosmetic.

The changes I've done are:

* We do have SAFE_MALLOC() so I replaced the malloc() + tst_brk()

* There is no point in closing fd before tst_brk() because cleanup() is
  called before test exit, which will close the fd anyways

-- 
Cyril Hrubis
chrubis@suse.cz
