From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Tue, 27 Jul 2021 11:20:55 +0300
Subject: [LTP] [PATCH v1] lib/tst_test.sh: skip test if ip returns
 "Error: Unknown device type"
In-Reply-To: <YPkjE3KHHnhYklp/@pevik>
References: <20210722063422.18059-1-radoslav.kolev@suse.com>
 <YPkjE3KHHnhYklp/@pevik>
Message-ID: <8b564e10-d87e-aaf0-03a4-1af347f02d4b@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/22/21 10:49 AM, Petr Vorel wrote:
> Hi Radoslav,
>
>> In network stress test groups there are tests expecting
>> CONFIG_NET_IPVTI to be enabled in the kernel, and if it's not they
>> fail. There is a check for VTI support in the ip utility, but not
>> for the kernel. Skip these tests if vti device type is not known by
>> the kernel.
> LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for the review, Petr!

Alexey, please let me know if you have any comments.


Regards,

Radoslav

