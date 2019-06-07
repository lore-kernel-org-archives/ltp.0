From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Jun 2019 13:35:37 +0200
Subject: [LTP] [PATCH v2] syscalls/acct02: add functional testcase
In-Reply-To: <7c7bf785-adbd-d69b-c17b-bc65c2228d11@suse.com>
References: <20190604072228.17513-1-camann@suse.com>
 <20190606121436.GB27083@rei>
 <7c7bf785-adbd-d69b-c17b-bc65c2228d11@suse.com>
Message-ID: <20190607113537.GA13869@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> yes, I have tested it on a system like you describe but I receive a
> positive output:
> 
> tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
> tst_test.c:1111: INFO: Timeout per run is 0h 05m 00s
> tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
> acct02.c:159: INFO: Verifying using 'struct acct'
> acct02.c:137: INFO: Number of accounting file entries tested: 1
> acct02.c:140: PASS: acct() wrote correct file contents!
> 
> There seems to be something else going wrong. I will investigate this.

May be something wrong at my end as well, what kernel versions have you
tested? At my end I tested 4.20.

-- 
Cyril Hrubis
chrubis@suse.cz
