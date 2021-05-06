From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 11:14:55 +0200
Subject: [LTP] [PATCH v2 2/2] IMA: Add test for dm-crypt measurement
In-Reply-To: <20200928035605.22701-3-tusharsu@linux.microsoft.com>
References: <20200928035605.22701-1-tusharsu@linux.microsoft.com>
 <20200928035605.22701-3-tusharsu@linux.microsoft.com>
Message-ID: <YJOzjw0k+ZgWaQO3@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Tushar, Mimi, Lakshmi,

> New functionality is being added to IMA to measure data provided by
> kernel components. With this feature, IMA policy can be set to enable
> measuring data provided by device-mapper targets. Currently one such
> device-mapper target - dm-crypt, is being updated to use this
> functionality. This new functionality needs test automation in LTP.

> Add a testcase which verifies that the IMA subsystem correctly measures
> the data coming from a device-mapper target - dm-crypt.

I noticed v10 patchset [1] has been merged, including SELinux commit
fdd1ffe8a812 ("selinux: include a consumer of the new IMA critical data hook"),
thus I merge this patchset.

I suppose fdd1ffe8a812 is the commit which should be mentioned in
ima_dm_crypt.sh, right? (the only change to v3 [2])

Kind regards,
Petr

[1] https://lore.kernel.org/linux-integrity/20210108040708.8389-1-tusharsu@linux.microsoft.com/
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=230766&state=*
