From: Cedric Hnyda <chnyda@suse.com>
Date: Fri, 13 Nov 2015 11:13:07 +0100
Subject: [LTP] new user to ltp
In-Reply-To: <5645B10B.9030708@aqueos.com>
References: <5645B10B.9030708@aqueos.com>
Message-ID: <5645B7B3.9000004@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On 11/13/2015 10:44 AM, Ghislain wrote:
> hi,
>
>  i stumbled upon this project while i was searching for a tool that 
> could tell me if my custom compiled kernel is not broken compared to 
> the one used in distro (as i nedded a patch applied). After trying the 
> ltp script i tried to run it on several kernels and both crashed even 
> the debian ones:
>
> - debian 3.16 (ionotify06)
inotify06 is a regression test for a bug in inotify which was fixed in 
kernel 4.2.
Other kernels are likely to panic.

Best regards,
Cedric

-- 
Cedric Hnyda

