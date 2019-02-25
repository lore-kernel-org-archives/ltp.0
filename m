From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Feb 2019 16:19:13 +0100
Subject: [LTP] [PATCH v4 0/9] syscalls: add sync device test-cases
In-Reply-To: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
References: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
Message-ID: <20190225151913.GA6132@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This patch-set adds common test for minimal sectors written on device
> for various sync related syscalls:
> 1. syncfs()
> 2. sync()
> 3. fsync()
> 4. fdatasync()
> 5. sync_file_range()
> 
> Also this test is run on all supported filesystems on a test block
> device.

Pushed with minor changes, good work, thanks.

I've changed the tests to print how much data was synced in a case of a
failure and also removed the TST_ prefix from the macros defined in the
tests as the TST_ prefix is reserved for the test library.

-- 
Cyril Hrubis
chrubis@suse.cz
