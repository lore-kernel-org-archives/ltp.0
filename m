From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jun 2018 16:11:45 +0200
Subject: [LTP] Regarding Use the Latest LTP on Latest YOCTO build
In-Reply-To: <CALYWmf98UHkNKAeR3EKTSGhKYzWCs-LjVoDSo=Ze1yfPGduYAQ@mail.gmail.com>
References: <CALYWmf98UHkNKAeR3EKTSGhKYzWCs-LjVoDSo=Ze1yfPGduYAQ@mail.gmail.com>
Message-ID: <20180627141145.GC32300@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am planning to use the LTP latest version on YOCTO latest vesion.
> It seems that the earlier YOCTO versions are released with LTP and
> latest version are not.
> Found the below difficulties so far:
> 1. Latest LTP version(20180118) suitable for old gcc version(4.8).
> 2. But at the same time, latest version of YOCTO build(2.3) supporting
> latest
> gcc version(6.3) only.
> 
> so we want to use a latest LTP version(20180118) with latest YOCTO
> build(2.3) which has latest gcc version(6.3) .
> 
> Please share your valuable inputs with me to achieve the same.

LTP should not depend on gcc version at all, it should compile fine with
anything new enough. We do test the build with travis for each commit
againts various gcc versions starting at 4.9 to gcc 7 and also with
several clang versions.

-- 
Cyril Hrubis
chrubis@suse.cz
