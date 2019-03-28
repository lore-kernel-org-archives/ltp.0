From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Mar 2019 10:04:26 +0100
Subject: [LTP] [PATCH 0/3] LTP reproducer on broken IMA on overlayfs
In-Reply-To: <20190327161638.7407-1-pvorel@suse.cz>
References: <20190327161638.7407-1-pvorel@suse.cz>
Message-ID: <20190328090426.GB32178@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Petr Vorel (3):
>   ima: Call test's cleanup inside ima_setup.sh cleanup
>   shell: Add $TST_DEVICE as default parameter to tst_umount
>   ima: Add overlay test
NOTE: I've posted just the third patch (didn't want to bother with
LTP specific non-IMA stuff. These are in LTP ML [1] [2] and also
downloadable via patchwork pwclient [3] [4].

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2019-March/011512.html
[2] http://lists.linux.it/pipermail/ltp/2019-March/011513.html
[3] https://patchwork.ozlabs.org/patch/1067177/
[4] https://patchwork.ozlabs.org/patch/1067178/
