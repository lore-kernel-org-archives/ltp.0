From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 8 Oct 2018 09:30:28 -0400 (EDT)
Subject: [LTP] LTP: keyctl05: unexpected error adding 'dns_resolver'
 key: EINVAL
In-Reply-To: <20181008132029.GA30978@rei>
References: <CA+G9fYvWRJ-+B_vXzFdnT2c9f0+o8p=RP23ZNAxMMzMd3TMbYQ@mail.gmail.com>
 <20181008132029.GA30978@rei>
Message-ID: <1688272539.56882810.1539005428232.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
> > keyctl05.c:135: INFO: Try to update the 'asymmetric' key...
> > keyctl05.c:148: PASS: updating 'asymmetric' key expectedly failed with
> > EOPNOTSUPP
> > keyctl05.c:119: BROK: unexpected error adding 'dns_resolver' key: EINVAL
> > tst_test.c:884: BROK: Test 1 haven't reported results!
> 
> Looks like kernel does not know 'dns_resolver' key type and as this type
> is registered by the dns_resolver code I suppose that you are missing
> some CONFIG_DNS_RESOLVER, if that is the case the test should handle
> EINVAL and return with TCONF.

I'm guessing it's
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/net/dns_resolver?id=bbb4c4323a4d9cb5ca04db904aa3050a7586839a
which added some additional checks.

Test currently uses 2 zeroes:

+        const struct dns_payload_header *bin;
...
+		if (datalen <= sizeof(*bin))
+			return -EINVAL;

+struct dns_payload_header {
+	__u8		zero;		/* Zero byte: marks this as not being text */
+	__u8		content;	/* enum dns_payload_content_type */
+	__u8		version;	/* Encoding version */
+} __packed;

and commit above appears to need 0x00 0x00 0x01 or 0xFF 0x00 to not return EINVAL.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
