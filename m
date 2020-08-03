From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 3 Aug 2020 08:18:22 -0400 (EDT)
Subject: [LTP] [PATCH] selftests: vdso: hash entry size on alpha,
 s390x is 8 bytes
In-Reply-To: <9927ed18c642db002e43afe5e36fb9c18c4f9495.1594811090.git.jstancek@redhat.com>
References: <9927ed18c642db002e43afe5e36fb9c18c4f9495.1594811090.git.jstancek@redhat.com>
Message-ID: <1881588710.5797015.1596457102422.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> parse_vdso.c is crashing on 5.8-rc5 s390x, because it wrongly reads
> nbucket as 0:
>   Program received signal SIGFPE, Arithmetic exception.
>   0x0000000001000f3e in vdso_sym (version=0x1001280 "LINUX_2.6",
>   name=0x100128a "__vdso_getcpu") at parse_vdso.c:207
>   207             ELF(Word) chain = vdso_info.bucket[elf_hash(name) %
>   vdso_info.nbucket];
>   (gdb) p vdso_info.nbucket
>   $1 = 0
> 
> Per readelf source:
>   https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=binutils/readelf.c;h=2406304fe35a832ac53aa7b1a367f3f7afed4264;hb=HEAD#l10027
> and objdump output hash entries are double size on 64bit s390 and alpha:
>   0000000000000120 <.hash>:
>    120:   00 00 00 00             .long   0x00000000
>    124:   00 00 00 03             .long   0x00000003
>    128:   00 00 00 00             .long   0x00000000
>    12c:   00 00 00 07             .long   0x00000007
>    130:   00 00 00 00             .long   0x00000000
>    134:   00 00 00 01             .long   0x00000001
>    138:   00 00 00 00             .long   0x00000000
>    13c:   00 00 00 05             .long   0x00000005
>    140:   00 00 00 00             .long   0x00000000
>    144:   00 00 00 06             .long   0x00000006
> 	  ...
>    16c:   00 00 00 02             .long   0x00000002
>    170:   00 00 00 00             .long   0x00000000
>    174:   00 00 00 03             .long   0x00000003
>    178:   00 00 00 00             .long   0x00000000
>    17c:   00 00 00 04             .long   0x00000004
> 
> Do similar check in parse_vdso.c and treat hash entries as double word.

Ping, any thoughts about the issue or patch?

