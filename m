From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Mar 2021 16:11:05 +0100
Subject: [LTP] [PATCH] cmdlib: Update exists function to exit with TCONF
In-Reply-To: <20210303093542.9292-1-kory.maincent@bootlin.com>
References: <20210303093542.9292-1-kory.maincent@bootlin.com>
Message-ID: <YD+nCa67sqLjZnSj@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +            tst_brkm TCONF NULL "$1: command $2 not found."
> +            exit 32

I've changed this to tst_resm, since it does not make any sense to use
the tst_brkm from apicmds and it only makes the code more confusing with
parameters that are not used at all.

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
