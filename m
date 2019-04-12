From: =?unknown-8bit?b?6Ziu5q2j5pe6?= <ruanzw@xiaopeng.com>
Date: Fri, 12 Apr 2019 23:41:44 +0800
Subject: [LTP] [PATCH v1] Fix build error caused by
 -Werror-implicit-function-declaration for Android
In-Reply-To: <20190411233330.GA381@x230>
References: <1554992323-14338-1-git-send-email-ruanzw@xiaopeng.com>
 <20190411233330.GA381@x230>
Message-ID: <8c3d3beb-156c-a063-ef56-36a12890e727@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

  Hi Petr,


-------- Original Message --------
From: Petr Vorel
Sent: Fri, 12 Apr 2019 01:33:30 +0200
To: Zhengwang Ruan
Cc: Ltp
Subject: Re: [LTP] [PATCH v1] Fix build error caused by 
-Werror-implicit-function-declaration for Android
> Hi,
>
>> Fix build errors caused by -Werror-implicit-function-declaration by add missing
>> <string.h> and <strings.h> for Android.
>> Signed-off-by: Zhengwang Ruan <ruanzw@xiaopeng.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Suggested-by: Petr Vorel <pvorel@suse.cz>
>
> See also
> http://lists.linux.it/pipermail/ltp/2019-April/011655.html
>
> Kind regards,
> Petr

Back to this thread, do you prefer this patch and accept it  now? :-)


Kind Regards,

Zhengwang

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190412/2d583e05/attachment-0001.html>
