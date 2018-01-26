From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Jan 2018 12:29:35 +0100
Subject: [LTP] [ltp][PATCH] runltp: Append ${LTPROOT}/bin to PATH
	variable
In-Reply-To: <2d5bf039-1b83-5e92-150d-e435e9f7d383@toshiba-tsdv.com>
References: <2d5bf039-1b83-5e92-150d-e435e9f7d383@toshiba-tsdv.com>
Message-ID: <20180126112935.GB2391@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Some executable files were installed to ${LTPROOT}/bin.
> So, We should append ${LTPROOT}/bin to PATH variable.

Here we should also describe that it fixes the ext4 testcases, other
than that this looks good.

You can either add it yourself and resend the patch or I can do that
before I apply the patch.

-- 
Cyril Hrubis
chrubis@suse.cz
