From: =?unknown-8bit?b?6Ziu5q2j5pe6?= <ruanzw@xiaopeng.com>
Date: Thu, 25 Apr 2019 11:13:12 +0800
Subject: [LTP] [PATCH v2] include/mk/env_post.mk: enable __ANDROID__
 definition for Android build
In-Reply-To: <15aeaa52-eecc-e21a-eb86-d66cfe81928e@google.com>
References: <1556124939-7699-1-git-send-email-ruanzw@xiaopeng.com>
 <15aeaa52-eecc-e21a-eb86-d66cfe81928e@google.com>
Message-ID: <8a940d16-ec78-b787-599d-c1a4cae69bf6@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Steve, Petr, Sandeep,


-------- Original Message --------
From: Steve Muckle
Sent: Wed, 24 Apr 2019 12:27:32 -0700
To: Zhengwang Ruan, Ltp, Petr Vorel, Sandeep Patil
Cc:
Subject: Re: [PATCH v2] include/mk/env_post.mk: enable __ANDROID__ 
definition for Android build
> On 4/24/19 9:55 AM, Zhengwang Ruan wrote:
>> The definition of __ANDROID__ has been widely used to compile 
>> android-specific
>> things (i.e. busybox [1] [2], dnsmasq [3]), so we expected NDK to 
>> automatically
>> pass it to help build LTP for android, but unfortunately it didn't 
>> (it is tested
>> with android-ndk-r19c). Currently, we have to manually specify 
>> -D__ANDROID__ in
>> configure step before launch 'make ANDROID=1' command, and this is 
>> suffering for
>> those who don't have good knowledge of LTP, so it is necessary to 
>> enable it if
>> built for android.
>
> Hi Zhengwang I mentioned in the other thread but just to get it here 
> also, __ANDROID__ seems to be defined for me by the NDK. Could you try 
> the steps Sandeep shared?

Yes, I tried. And it proves NDK has defined it, and this patch is not 
needed.

Thank you guys very much for your time and helping me review this.

--

Kind Regards,

Zhengwang

>
> thanks,
> steve
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190425/44dce375/attachment.html>
