From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 1 Jan 2019 14:34:08 +0100
Subject: [LTP] [PATCH] network/busy_poll: Change the "ethtool
 --show-features to "ethtool -k"
In-Reply-To: <20181231103126.3679-1-sun_lianwen@163.com>
References: <20181231103126.3679-1-sun_lianwen@163.com>
Message-ID: <20190101133408.GA20094@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Sun,

> To keep the same struct of "ethtool -i $(tst_iface)",
> change the "ethtool --show-features" to "ethtool -k".

--show-features is the same as -k, so what is the improvement?

Kind regards,
Petr
