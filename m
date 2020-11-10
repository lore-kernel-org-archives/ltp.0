From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 10 Nov 2020 17:31:12 +0300
Subject: [LTP] [PATCH v3] tcp_cmds/ping/ping02: Make it compatible with
 Busybox
In-Reply-To: <20201110123616.GA31347@pevik>
References: <20201109191618.4442-1-kory.maincent@bootlin.com>
 <20201110122854.GA30193@pevik> <20201110123616.GA31347@pevik>
Message-ID: <48e1bd71-021d-d405-fd67-c35dcd8b53e2@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10.11.2020 15:36, Petr Vorel wrote:
> Hi Kory, Alexey,
> 
>> -i option was added in busybox 1.30 (2 years old), it'd be good to note that in
>> the commit message.
> Actually, maybe also test -i option and if even -i not working run?
> 
> tst_brk TCONF "unsupported ping version (old busybox?)"

Hi Petr,

What if it failed for some other reason, it would be a wrong assumption
that ping doesn't support -i...
