From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 27 May 2019 15:54:27 +0200
Subject: [LTP] [PATCH v1] syscalls/setsockopt04: Add CVE-2016-9793
 testcase
In-Reply-To: <20190527094146.13561-1-camann@suse.com>
References: <20190527094146.13561-1-camann@suse.com>
Message-ID: <20190527135427.GB23658@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've removed the .timeout settings from the tst_test structure and
pushed, thanks.

As far as I can tell there is no point in tweaking the default timeout
for testcases that have runtime in miliseconds.

-- 
Cyril Hrubis
chrubis@suse.cz
