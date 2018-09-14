From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 14 Sep 2018 14:41:27 +0300
Subject: [LTP] [PATCH v2 1/4] lib/tst_test.c: add 'needs_drivers' option
 with tst_check_drivers cmd
In-Reply-To: <20180913122712.GA18036@rei.lan>
References: <1534764229-26993-1-git-send-email-alexey.kodanev@oracle.com>
 <20180913122712.GA18036@rei.lan>
Message-ID: <3391e72b-43d2-9cb5-77b2-731b2343b2f3@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09/13/2018 03:27 PM, Cyril Hrubis wrote:
> Hi!
>> +2.2.26 Checking kernel for the driver support
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> +Someties test needs certain drivers to be available in the kernel and must
>> +end with TCONF if any are missing. For this task there is the '.needs_drivers'
>> +option which accepts NULL-terminated array of the drivers names.
> 
> Maybe we should explicitly say here that this works for both drivers
> that are compiled-in and modules, since otherwise this may confuse the
> users, especially since we talk about modprobe in the next paragraph.
> 
> I would write something as:
> 
> "Some tests may need specific kernel drivers, either compiled in, or
> loaded as a module. If .need_drivers points to a NULL-terminated array
> of kernel module names these are all checked and the test exits with
> TCONF on first missing driver."
> 

OK, thanks! I guess this also correlates with using the --dry-run option
of modprobe that I'm going to add in the 3rd version [1], if there are no
objections.

[1] http://lists.linux.it/pipermail/ltp/2018-August/009128.html
