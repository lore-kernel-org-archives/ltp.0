From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 4 Jan 2021 12:24:17 +0100
Subject: [LTP] [PATCH] containers/netns: update netns shell test to new
 API
In-Reply-To: <X/LkQDXDehooa9wu@pevik>
References: <20201211172047.26640-1-kory.maincent@bootlin.com>
 <X/LkQDXDehooa9wu@pevik>
Message-ID: <X/L64TayQE8B+SZ+@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kory,

> Before merge I'll drop bogus '# TEST CASE #N' and add few TINFO messages, e.g.:
> tst_res TINFO "controlling device over netlink"
Thanks for your work, merged.
In the end without tst_res TINFO messages and added one cleanup commit.

I'm going to send a patch to ML which fixes tst_check_iproute check for recent
iproute2, which uses since v5.8.0 (actually since v5.7.0-77-gb687d1067169)
kernel version.

Kind regards,
Petr
