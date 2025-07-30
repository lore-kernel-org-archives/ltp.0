Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D47EC83F26
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 17:09:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 844B23CB6C3
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 19:09:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E4D93C0565
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 19:09:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 501911A00484
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 19:09:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3033621A93;
 Wed, 30 Jul 2025 17:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753895359;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a+IEKPMtGpjB45z7412KHqa28SqP35r0YnVL4YfjgUk=;
 b=R7Z0kiHjTLbhIKltfqluKaEI0dvCVUN6U/lBOSwSOozvlLJmtVIczlk7igeAFJaopJh8c8
 mzuLdFVOWmoKadA8kFPEUJ9P8oj8idcQdqUtjJfoMRBIAecpdptKQBOQSAwkE/OTmEboeA
 E2xMAYTA3r3i2V5HiEwOgN+1fs7Y2fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753895359;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a+IEKPMtGpjB45z7412KHqa28SqP35r0YnVL4YfjgUk=;
 b=bsb4rBrbCQLUZ+ZuUEfGfNn3pOZZQO5v4syvS6CZfteoB8QZsViA7NhhgA0+GCwvWHnKoI
 sIarFhMj2xhDyGBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753895359;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a+IEKPMtGpjB45z7412KHqa28SqP35r0YnVL4YfjgUk=;
 b=R7Z0kiHjTLbhIKltfqluKaEI0dvCVUN6U/lBOSwSOozvlLJmtVIczlk7igeAFJaopJh8c8
 mzuLdFVOWmoKadA8kFPEUJ9P8oj8idcQdqUtjJfoMRBIAecpdptKQBOQSAwkE/OTmEboeA
 E2xMAYTA3r3i2V5HiEwOgN+1fs7Y2fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753895359;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a+IEKPMtGpjB45z7412KHqa28SqP35r0YnVL4YfjgUk=;
 b=bsb4rBrbCQLUZ+ZuUEfGfNn3pOZZQO5v4syvS6CZfteoB8QZsViA7NhhgA0+GCwvWHnKoI
 sIarFhMj2xhDyGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0049A13942;
 Wed, 30 Jul 2025 17:09:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BXdhOr5RimhQAQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Jul 2025 17:09:18 +0000
Date: Wed, 30 Jul 2025 19:09:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250730170913.GB673913@pevik>
References: <20250718-doc_kvm_tests-v1-1-47519ff26d62@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250718-doc_kvm_tests-v1-1-47519ff26d62@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: add kvm tests documentation
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Converted KVM Tests API documentation into RST format and fixed
> grammatical errors in the text.

Thanks for doing this!
I'm ok if you ignore moving to header (it should be done, but it can be done
later).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +Basic KVM Test Structure
> +------------------------
> +
> +KVM tests are simple C source files containing both the KVM controller code
> +and the guest payload code separated by ``#ifdef COMPILE_PAYLOAD`` preprocessor
> +condition. The file will be compiled twice: once to compile the payload part,
> +and once to compile the KVM controller part and embed the payload binary inside.
> +The result is a single self-contained binary that will execute the embedded
> +payload inside a KVM virtual machine and print results in the same format as
> +a normal LTP test.
> +
> +A KVM test source should start with ``#include "kvm_test.h"`` instead of the
> +usual ``tst_test.h``. The ``kvm_test.h`` header file will include the other basic
nit: I would prefer if headers could be clickable links, as it's done in
developers/test_case_tutorial.rst (i.e. consistency + allow reader to quickly
see the source). E.g.:

usual :master:`include/tst_test.h`. The :master:`include/kvm_test.h` header file
will include the other basic ...

But I can do this and the other later (no need to send v2.

> +headers appropriate for the current compilation pass. Everything else in the
> +source file should be enclosed in ``#ifdef COMPILE_PAYLOAD ... #else ... #endif``
> +condition, including any other header file includes. Note that the standard
> +LTP headers are not available in the payload compilation pass; only the KVM
> +guest library headers can be included.
> +
> +.. _example-kvm-test:
> +
> +.. rubric:: Example KVM Test
> +
> +.. code-block:: c
> +
> +    #include "kvm_test.h"
> +
> +    #ifdef COMPILE_PAYLOAD
> +
> +    /* Guest payload code */
> +
> +    void main(void)
> +    {
> +    	tst_res(TPASS, "Hello, world!");
Here you started using tabs.
Could you convert it to spaces before merge?
(Mixing tabs and spaces on places where they are used for syntax formatting will
lead sooner or later to broken output.)

> +    }
> +
> +    #else /* COMPILE_PAYLOAD */
> +
> +    /* KVM controller code */
> +
> +    static struct tst_test test = {
> +    	.test_all = tst_kvm_run,
> +    	.setup = tst_kvm_setup,
> +    	.cleanup = tst_kvm_cleanup,
And these 3 lines as well.

> +    };
> +
> +    #endif /* COMPILE_PAYLOAD */
> +
> +The KVM controller code is a normal LTP test and needs to define an instance
> +of ``struct tst_test`` with metadata and the usual setup, cleanup, and test
Please could you use ref syntax for all structs? i.e.
:ref:`struct tst_test`

This way it's clickable and consistent with other parts of the docs.
It can be done before merge.

> +functions. Basic implementation of all three functions is provided by the KVM
> +host library.
> +
> +On the other hand, the payload is essentially a tiny kernel that will run
> +on bare virtual hardware. It cannot access any files, Linux syscalls, standard
> +library functions, etc., except for the small subset provided by the KVM guest
> +library. The payload code must define a ``void main(void)`` function which will
> +be the VM entry point of the test.
> +
> +KVM Host Library
> +----------------
> +
> +The KVM host library provides helper functions for creating and running
> +a minimal KVM virtual machine.
> +
> +Data Structures
> +~~~~~~~~~~~~~~~
> +
> +.. code-block:: c
> +
> +    struct tst_kvm_instance {
Well, this should be now in testcases/kernel/kvm/include/kvm_host.h.
Would it be too much work to add kernel doc to it and include it in docs?
Doing it properly would help with struct being clickable from other places.
It applies to the rest of the document.

> +    	int vm_fd, vcpu_fd;
> +    	struct kvm_run *vcpu_info;
> +    	size_t vcpu_info_size;
> +    	struct kvm_userspace_memory_region ram[MAX_KVM_MEMSLOTS];
> +    	struct tst_kvm_result *result;
Here also tabs => spaces (in case you keep the docs here).

> +    };
> +
> +``struct tst_kvm_instance`` holds the file descriptors and memory buffers
> +of a single KVM virtual machine:
> +
> +* ``int vm_fd`` is the main VM file descriptor created by ``ioctl(KVM_CREATE_VM)``
> +* ``int vcpu_fd`` is the virtual CPU file descriptor created by
> +  ``ioctl(KVM_CREATE_VCPU)``
> +* ``struct kvm_run *vcpu_info`` is the VCPU state structure created by
> +  ``mmap(vcpu_fd)``
> +* ``size_t vcpu_info_size`` is the size of ``vcpu_info`` buffer
> +* ``struct kvm_userspace_memory_region ram[MAX_KVM_MEMSLOTS]`` is the list
> +  of memory slots defined in this VM. Unused memory slots have zero
> +  in the ``userspace_addr`` field.
> +* ``struct tst_kvm_result *result`` is a buffer for passing test result data
> +  from the VM to the controller program, mainly ``tst_res()``/``tst_brk()`` flags
> +  and messages.
This explanation should be really in the header.

> +
> +.. code-block:: c
> +
> +    struct tst_kvm_result {
> +    	int32_t result;
> +    	int32_t lineno;
> +    	uint64_t file_addr;
> +    	char message[0];
Here also tabs => spaces (in case you keep the docs here).

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
