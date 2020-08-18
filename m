From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 Aug 2020 17:20:05 +0200
Subject: [LTP] [PATCH 1/4] Integrate tst_taint_check() into main LTP
 library
In-Reply-To: <ddde012b-5060-a49e-33dd-bdb6bfcb3e0d@suse.cz>
References: <20200811130502.12010-1-mdoucha@suse.cz>
 <1124120972.9071386.1597758876284.JavaMail.zimbra@redhat.com>
 <ddde012b-5060-a49e-33dd-bdb6bfcb3e0d@suse.cz>
Message-ID: <20200818152005.GF27964@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The difference matters only in tests that have .all_filesystems = 1.
> With TBROK, taint will kill the test when the current FS run finishes.
> With TFAIL, the test will run through the remaining filesystems with
> broken kernel and print the taint error message after each one (most
> likely with lots of bogus errors on top).
> 
> I prefer the first behavior.

As long as you return TFAIL from the function the test will exit.

-- 
Cyril Hrubis
chrubis@suse.cz
