From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Nov 2019 12:00:39 +0100
Subject: [LTP] [PATCH] open_posix/pi_test*: Remove all tests
In-Reply-To: <20191118074455.42014-1-lkml@jv-coder.de>
References: <20191118074455.42014-1-lkml@jv-coder.de>
Message-ID: <20191121110039.GB30913@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

> There are several reasons, why these tests should be removed.
> Most important: They do not really test anything. The result of these
> tests has to be inspected manually do check, if the behavior is correct,
> but the manual inspection using the given tools is not possible, because
> these tests were written for systems much slower than todays systems.
> The problems are described in more detail in
> https://github.com/linux-test-project/ltp/issues/584

Thanks, merged!

Kind regards,
Petr
