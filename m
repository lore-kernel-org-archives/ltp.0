From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 14 Mar 2016 08:10:39 -0400 (EDT)
Subject: [LTP] Question about perf_event_open/Cap_bounds/su01 test cases
In-Reply-To: <AF04265A3FC2B144B9892F621A394E13EA3E5105@tethys>
References: <AF04265A3FC2B144B9892F621A394E13EA3DB009@tethys>
 <20160309140859.GD28171@rei.lan>
 <AF04265A3FC2B144B9892F621A394E13EA3E2813@tethys>
 <1530717335.8635366.1457710519514.JavaMail.zimbra@redhat.com>
 <AF04265A3FC2B144B9892F621A394E13EA3E463C@tethys>
 <1590944740.8814844.1457790352389.JavaMail.zimbra@redhat.com>
 <AF04265A3FC2B144B9892F621A394E13EA3E5105@tethys>
Message-ID: <1284145136.9339833.1457957439775.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Julio Cruz Barroso" <julio.cruz@smartmatic.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "Cyril Hrubis" <chrubis@suse.cz>, ltp@lists.linux.it
> Sent: Sunday, 13 March, 2016 12:39:35 PM
> Subject: RE: [LTP] Question about perf_event_open/Cap_bounds/su01 test cases
> The following test cases were fixed (attached patches for revision):

Hi,

Please post each patch separately. You're missing Signed-off-by in each
and some introduce white-space errors. You can check your patches
with ./scripts/checkpatch.pl in linux kernel tree. Also description
could be a bit more verbose to explain "why" a patch is proposed.

> 
> - Cap_bounds: Change test to go only up to min(CAP_LAST_CAP,
> /proc/sys/kernel/cap_last_cap)

I made some tweaks here, fixed white-space errors, added check
for proc file (older kernels don't have it), fixed an error,
where CAP_LAST_CAP was used outside "#ifdef HAVE_LIBCAP"
and pushed.

> - getrusage03: Check available memory to run grandchild_maxrss, zombie and
> sig_ign

"unsigned long availMem" should be fine if you first divide pagesize by 1024.
The "100" you picked as a threshold should be a define. Also it would be better
if you moved it to other side of comparison. If someone has less than 100MB
available memory then subtraction will underflow unsigned long.

> - mtest06_2: The default test case want to use 1G or more. Change GB to MB
> for embedded devices (in mmap2.c).

This needs an explanation and also to answer if this
testcase will still be valid for non-embedded devices.

Regards,
Jan
