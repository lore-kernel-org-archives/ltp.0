From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 May 2016 17:55:31 +0200
Subject: [LTP] [PATCH V2 6/9] testcases/lib: Add tst_random decmical
 integer generator
In-Reply-To: <107593102.43362349.1462374250852.JavaMail.zimbra@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-2-git-send-email-chuhu@redhat.com>
 <1460966656-28328-3-git-send-email-chuhu@redhat.com>
 <1460966656-28328-4-git-send-email-chuhu@redhat.com>
 <1460966656-28328-5-git-send-email-chuhu@redhat.com>
 <1460966656-28328-6-git-send-email-chuhu@redhat.com>
 <1460966656-28328-7-git-send-email-chuhu@redhat.com>
 <20160504133453.GD12244@rei.lan>
 <107593102.43362349.1462374250852.JavaMail.zimbra@redhat.com>
Message-ID: <20160504155531.GA22563@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Looks like we just need to compare with ( *end != '\0' ), as argv[1] or 
> argv[2] can't be '\0' (NULL) as it has been filtered by (argc <2 || argc > 3).
> 
> And i just verified this with this debug line: 
> 
>    printf("end = %p, *end = %c\n", end, *end);

What will happen when you call:

tst_random "" ""

Or more realistic case when FOO is not defined and you do:

tst_random "$FOO"

Note that empty string in C is an array with first element set to 0.

-- 
Cyril Hrubis
chrubis@suse.cz
