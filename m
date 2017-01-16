From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 16 Jan 2017 12:50:57 +0100
Subject: [LTP] [PATCH] quotactl01: replace int comparison with memcmp
In-Reply-To: <74ba2553e066b29871bd1e16f00755eb57747fc8.1484307598.git.jstancek@redhat.com>
References: <74ba2553e066b29871bd1e16f00755eb57747fc8.1484307598.git.jstancek@redhat.com>
Message-ID: <20170116115056.GB23274@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	memset(fmt_buf, 0, sizeof(fmt_buf));
> +	memset(&fmt_buf, 0, sizeof(fmt_buf));

Hmm, we can simply do fmt_buf = 0 here now, right?

Otherwise this looks good, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
