From: Chunyu Hu <chuhu@redhat.com>
Date: Wed, 4 May 2016 19:40:11 -0400 (EDT)
Subject: [LTP] [PATCH V2 6/9] testcases/lib: Add tst_random decmical
 integer generator
In-Reply-To: <460634976.43409113.1462379310070.JavaMail.zimbra@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-5-git-send-email-chuhu@redhat.com>
 <1460966656-28328-6-git-send-email-chuhu@redhat.com>
 <1460966656-28328-7-git-send-email-chuhu@redhat.com>
 <20160504133453.GD12244@rei.lan>
 <107593102.43362349.1462374250852.JavaMail.zimbra@redhat.com>
 <20160504155531.GA22563@rei>
 <460634976.43409113.1462379310070.JavaMail.zimbra@redhat.com>
Message-ID: <1660635214.43471855.1462405211481.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Chunyu Hu" <chuhu@redhat.com>
> To: "Cyril Hrubis" <chrubis@suse.cz>
> Cc: liwan@redhat.com, ltp@lists.linux.it
> Sent: Thursday, May 5, 2016 12:28:30 AM
> Subject: Re: [LTP] [PATCH V2 6/9] testcases/lib: Add tst_random decmical integer generator
> 
> 
> 
> ----- Original Message -----
> > From: "Cyril Hrubis" <chrubis@suse.cz>
> > To: "Chunyu Hu" <chuhu@redhat.com>
> > Cc: ltp@lists.linux.it, liwan@redhat.com
> > Sent: Wednesday, May 4, 2016 11:55:31 PM
> > Subject: Re: [LTP] [PATCH V2 6/9] testcases/lib: Add tst_random decmical
> > integer generator
> > 
> > Hi!
> > > Looks like we just need to compare with ( *end != '\0' ), as argv[1] or
> > > argv[2] can't be '\0' (NULL) as it has been filtered by (argc <2 || argc
> > > >
> > > 3).

I proved to be wrong, which pointed bye you  below. BTW, i also
changed the argc check way to 

 if (argc != 2 && argc != 3)

I think this clearer than 
 if (argc < 2 || argc > 3 )



> > > And i just verified this with this debug line:
> > > 
> > >    printf("end = %p, *end = %c\n", end, *end);
> > 
> > What will happen when you call:
> > 
> > tst_random "" ""
> > 
> > Or more realistic case when FOO is not defined and you do:
> > 
> > tst_random "$FOO"
> > 
> > Note that empty string in C is an array with first element set to 0.
> 
> I was so hurried to send out the patch :/. You are right. I missed your
> mentioned here.  I added some debug line, proving you are right.
> 
> 
>         printf("argv[1] = [%d]\n", argv[1][0]);
>         printf("argv[3] = [%d]\n", argv[3]);
>         printf("end = %p, *end = [%d]\n", end, *end);
> 
> ./a.out "" ""
> 
> argv[1] = [0]
> argv[3] = [0]
> end = 0x7ffc3d49861f, *end = [0]
> 
> I will reorganize this check later, my brain is so slow now. Thank you.

after some rest, i considered it as your suggestion and man page. I think
below condition is enough, if you don't have objection for this, i will 
use this in next step. Thanks.

if (!(argv[1][0] != '\0' && *end == '\0'))


> 
> > --
> > Cyril Hrubis
> > chrubis@suse.cz
> > 
> 
> --
> Regards,
> Chunyu Hu
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Regards,
Chunyu Hu

