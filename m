From: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Mon, 23 Aug 2021 10:34:54 -0400
Subject: [LTP] [PATCH 3/7] syscalls/fanotify20: Validate incoming FID in
 FAN_FS_ERROR
In-Reply-To: <YSAlb7XGUNoc73ZJ@google.com> (Matthew Bobrowski's message of
 "Sat, 21 Aug 2021 07:58:07 +1000")
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-4-krisman@collabora.com>
 <CAOQ4uxjMfJM4FM4tWJWgjbK4a2K1hNJdEBRvwQTh9+5su2N0Tw@mail.gmail.com>
 <87fsvphksu.fsf@collabora.com>
 <CAOQ4uxj_WwDPxZv0nr9+Hh+pim6+2onaBdFq_BR-qK=xz+8yUg@mail.gmail.com>
 <YR+CH2+GYzwU2/SG@pevik> <YSAlb7XGUNoc73ZJ@google.com>
Message-ID: <87o89o2prl.fsf@collabora.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Matthew Bobrowski <repnop@google.com> writes:

> Hey Gabriel,
>
> On Fri, Aug 20, 2021 at 12:21:19PM +0200, Petr Vorel wrote:
>> Hi all,
>> 
>> > No problem. That's what review is for ;-)
>> 
>> > BTW, unless anyone is specifically interested I don't think there
>> > is a reason to re post the test patches before the submission request.
>> > Certainly not for the small fixes that I requested.
>> 
>> > I do request that you post a link to a branch with the fixed test
>> > so that we can experiment with the kernel patches.
>> 
>> > I've also CC'ed Matthew who may want to help with review of the test
>> > and man page that you posted in the cover letter [1].
>> 
>> @Amir Thanks a lot for your review, agree with all you mentioned.
>> 
>> @Gabriel Thanks for your contribution. I'd also consider squashing some of the
>> commits.
>
> Is the FAN_FS_ERROR feature to be included within the 5.15 release? If so,
> I may need to do some shuffling around as these LTP tests collide with the
> ones I author for the FAN_REPORT_PIDFD series.
>

Matthew,

Hi, sorry for the delay.  I took a short vacation and couldn't follow
up.  I think it is too late for 5.15, please go ahead with
FAN_REPORT_PIDFD series and I will consider them in my future
submission.

Thank you,


-- 
Gabriel Krisman Bertazi
