From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Jul 2021 17:11:17 +0200
Subject: [LTP] [PATCH 2/2] syscalls/read04: Convert to new API
In-Reply-To: <20210610091043.900863-2-ruansy.fnst@fujitsu.com>
References: <20210610091043.900863-1-ruansy.fnst@fujitsu.com>
 <20210610091043.900863-2-ruansy.fnst@fujitsu.com>
Message-ID: <YOxblezBZT3trfTi@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor changes, thanks.

The main change was that I renamed the TST_SIZE to PALFA_LEN since
anything with tst_ or TST_ prefix is reserved for the test library, test
must not define ideintifiers with these prefixes.

-- 
Cyril Hrubis
chrubis@suse.cz
