From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Jan 2017 16:02:22 +0100
Subject: [LTP] [PATCH v2 1/3] tst_test: add tst_parse_long()
In-Reply-To: <1482255068-25771-1-git-send-email-alexey.kodanev@oracle.com>
References: <1482255068-25771-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20170123150221.GF25788@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> v2: Fixes in tst_parse_int():
>     * return back checking 'str' for NULL
>     * set value in tst_parse_int() only if 'long' version returns 0.

Ah, these are good fixes, I missed these in the v1 too.

-- 
Cyril Hrubis
chrubis@suse.cz
