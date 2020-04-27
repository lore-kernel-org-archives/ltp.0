From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Apr 2020 07:31:25 +0200
Subject: [LTP] [PATCH] Add env variable as workaround for test issues in
 VMs
In-Reply-To: <20200424150422.17467-1-mdoucha@suse.cz>
References: <20200424150422.17467-1-mdoucha@suse.cz>
Message-ID: <20200427053125.GA21164@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Timer tests often fail on sleep overrun when LTP is running inside a VM.
> The main cause is usually that the VM doesn't get enough CPU time to wake up
> the test process in time.
Cannot we detect presence of "hypervisor" in flags in /proc/cpuinfo?
I though it was quite reliable for detecting VM.

> Disable upper bound checks in the tst_timer_test library if LTP_VM_ENV is set
> to non-zero value.

Kind regards,
Petr
