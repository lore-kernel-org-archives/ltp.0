From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 8 Mar 2019 16:09:57 +0100
Subject: [LTP] [PATCH 2/2 v2] libs: Hook up libs into the build system
In-Reply-To: <20190308140354.GC20072@rei>
References: <20190308124257.25282-1-chrubis@suse.cz>
 <20190308124257.25282-2-chrubis@suse.cz>
 <1327941462.6119620.1552050333572.JavaMail.zimbra@redhat.com>
 <20190308132634.GA23955@dell5510> <20190308133347.GB20072@rei>
 <20190308140354.GC20072@rei>
Message-ID: <20190308150957.GA30032@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> And on my machine out-of-tree build does not managed to get past
> configure step, it fails somewhere in the ffsb configure step.
I often get
configure:2889: error: source directory already configured; run "make distclean" there first

So I build it with a bit drastic way:
rm -rfv *; git reset --hard; ./build.sh -o out


Kind regards,
Petr
