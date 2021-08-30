From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Aug 2021 17:23:21 +0200
Subject: [LTP] [PATCH 1/3] bpf: Print full verification log
In-Reply-To: <20210827051309.28521-1-rpalethorpe@suse.com>
References: <20210827051309.28521-1-rpalethorpe@suse.com>
Message-ID: <YSz36VZ18+N4YsM/@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The log never falls within the 1024 byte limit imposed by format
> string buffer. So print it separately with dprintf.

I guess that it would be slightly cleaner to add tst_printf() which
would print the output so that we don't have to hardcode printing data
into STDERR in the test like this.

-- 
Cyril Hrubis
chrubis@suse.cz
