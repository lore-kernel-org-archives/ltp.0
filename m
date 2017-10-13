From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Oct 2017 14:27:03 +0200
Subject: [LTP] [PATCH v3 09/18] m4: Fix libcrypto detection on 32-bit
 cross build
In-Reply-To: <20171012183335.24568-10-pvorel@suse.cz>
References: <20171012183335.24568-1-pvorel@suse.cz>
 <20171012183335.24568-10-pvorel@suse.cz>
Message-ID: <20171013122703.GF17900@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#else
> +int main(void)
> +{
> +	tst_resm(TCONF, "test requires libcrypto and openssl development packages");
         ^
	 I've changed these to tst_brkm() otherwise the return value
	 from main() would be undefined because these are oldlib tests
	 that has to either call tst_exit() or tst_brkm() to actually
	 exit the test.

-- 
Cyril Hrubis
chrubis@suse.cz
