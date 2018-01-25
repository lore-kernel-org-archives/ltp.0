From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 25 Jan 2018 21:40:13 +0100
Subject: [LTP] [RFC PATCH 0/2] IMA: Rewrite tests into new API + fixes
In-Reply-To: <20180125203057.mzzpilp6i43xftka@dell5510>
References: <20180111202821.31639-1-pvorel@suse.cz>
 <1516815417.3686.55.camel@linux.vnet.ibm.com>
 <20180125203057.mzzpilp6i43xftka@dell5510>
Message-ID: <20180125204013.byhskc2xkp7iexko@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mimi,

> > Since these tests were first written, Roberto's IMA templates and
> > Dmitry's support for larger digests were upstreamed.  With the new
> > template format, the file hash is prefixed with the hash algorithm.
> >  Before comparing the calculated boot aggregate with the value in the
> > IMA measurement list, the hash algorithm needs to be removed.
> Do you mean entries in /sys/kernel/security/ima/ascii_runtime_measurements ?
> system with config CONFIG_IMA_DEFAULT_HASH_SHA256=y
> 10 4814642f7955ad7a9c7b47785d002374b34902fd ima-ng sha256:f20cec9d158c4c453899f97595c40257c2518a40a310a550a1cd26a63e7fff7a /usr/lib64/libsha1detectcoll.so.1.0.0
> system with config CONFIG_IMA_DEFAULT_HASH_SHA1=y
> 10 2990cfe74ff309268e4fb928102574c28f9bb876 ima-ng sha1:71b543ad6af36b0976d0e3f71fed4ce0954eda0c /var/log/messages

> As it's done with grep it shouldn't be needed:
> grep -q '^CONFIG_IMA_DEFAULT_HASH_SHA256=y' /boot/config-$(uname -r) && \
> 		HASH_COMMAND="sha256sum"

Here is the part where I grep.
ASCII_MEASUREMENTS="$IMA_DIR/ascii_runtime_measurements" # from ima_setup.sh
ima_check()
{
	EXPECT_PASS grep -q $($HASH_COMMAND $TEST_FILE) $ASCII_MEASUREMENTS
}

Or is it your note for other test.

BTW as I don't have any TPM hw, it would be great if anyone with it could test the code.


Kind regards,
Petr
