From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 07 Nov 2019 11:33:11 +0100
Subject: [LTP] [PATCH v2 1/2] read_all: move blacklist to source
In-Reply-To: <2124877733.10763434.1573054117742.JavaMail.zimbra@redhat.com>
References: <4647b3bced96c66c040078a32c13dab65558816d.1572956488.git.jstancek@redhat.com>
 <87o8xpdw0l.fsf@rpws.prws.suse.cz>
 <2124877733.10763434.1573054117742.JavaMail.zimbra@redhat.com>
Message-ID: <87lfssdli0.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Jan Stancek <jstancek@redhat.com> writes:

> ----- Original Message -----
>> > +static char *blacklist[] = {
>> > +	NULL, /* reserved for -e parameter */
>> > +	"/sys/power/wakeup_count",
>> > +};
>>
>> The problem with this is that it is only required if we are running as a
>> privileged user. If -p is specified then it would be a bug if nobody can
>> read from any of these files.
>>
>> So I guess we could disable the builtin blacklist if drop_privs (switch
>> to nobody) is specified
>
> Good point. I just saw your reply that you plan to send a patch, thank
> you.

Thanks!

>
>> and run this test twice on /sys with and without
>> -p.
>
> greg-kh wasn't very happy to hear about privileged runs in the other thread.
> He was suggesting whitelist approach, but I don't know how we would keep it
> up to date, deal with different configs, etc.

--
Thank you,
Richard.
