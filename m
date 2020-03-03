From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 3 Mar 2020 12:37:46 +0100
Subject: [LTP] [PATCH v2] Add test for CVE 2017-10661
In-Reply-To: <74b99e9f-12a3-6d5b-2d14-16fd3cbd4c71@suse.cz>
References: <20200221120850.15874-1-mdoucha@suse.cz>
 <20200303104737.GA42129@gacrux.arch.suse.de>
 <20200303110249.GB42129@gacrux.arch.suse.de>
 <20200303112725.GA24389@rei.lan>
 <74b99e9f-12a3-6d5b-2d14-16fd3cbd4c71@suse.cz>
Message-ID: <20200303113746.GB42769@gacrux.arch.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> Ah, right. I broke the Makefile when I deleted the unconditional LDLIBS
> line... The -lpthread was useless but I didn't realize the -lrt was needed.

> I'll resubmit with all fixes mentioned so far then.
OK, thanks for doing new version.

Kind regards,
Petr
