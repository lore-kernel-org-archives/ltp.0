From: Cedric Hnyda <chnyda@suse.com>
Date: Thu, 5 Nov 2015 16:16:00 +0100
Subject: [LTP] [PATCH V2] controllers/cgroup_fj: fix and clean up
In-Reply-To: <20151105140242.GC7226@rei>
References: <1446458018-20866-1-git-send-email-chnyda@suse.com>
 <20151105140242.GC7226@rei>
Message-ID: <563B72B0.7020004@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 11/05/2015 03:02 PM, Cyril Hrubis wrote:
> ...
>> +get_mount_point()
>> +{
>> +	check_point=`grep -w $subsystem /proc/mounts | cut -f 2 | cut -d " " -f2`
> I would do even more specific:
>
> grep -w "^$subsystem"
>
> which would match only lines that begin with word "$subsystem".
>
>
> Otherwise this looks good.
>
Thanks for the review.
The format of /proc/mounts is not stable so it might be better to keep
things like they are.

-- 
Cedric Hnyda

