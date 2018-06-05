From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Jun 2018 13:02:46 +0200
Subject: [LTP] [PATCH] testcase: kernel: ioctl: Handle ENOENT error
In-Reply-To: <20180529155335.5224-1-mylene.josserand@bootlin.com>
References: <20180529155335.5224-1-mylene.josserand@bootlin.com>
Message-ID: <20180605110246.GA29837@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In case the folder /dev/net is not available, the error
> returned is ENOENT and not ENODEV.
> Handle this case to return a TCONF instead of a TFAIL.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
