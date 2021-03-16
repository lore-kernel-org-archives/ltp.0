From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 16 Mar 2021 12:54:07 +0100
Subject: [LTP] [PATCH] IMA: Add test for selinux measurement
In-Reply-To: <20210222023805.12846-1-nramas@linux.microsoft.com>
References: <20210222023805.12846-1-nramas@linux.microsoft.com>
Message-ID: <YFCcX8VM2KsMmuQ1@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lakshmi, Mimi,

> New functionality has been added in IMA to measure data that is
> critical to the integrity of the system.  SELinux uses this feature
> to measure the hash of the SELinux policy loaded in kernel memory,
> and the current state of various SELinux configuration.  This new
> functionality needs test automation in LTP.

> Add test cases which verify that the IMA subsystem correctly
> measures the data provided by SELinux.

I finally merged this patchset, noted both kernel commits.
Thanks for this test!

Kind regards,
Petr

* fdd1ffe8a812 ("selinux: include a consumer of the new IMA critical data hook")
(v5.12-rc1-dontuse)
* 2554a48f4437 ("selinux: measure state and policy capabilities")
(to be in v5.13
