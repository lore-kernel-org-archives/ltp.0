Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49757C433EF
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 10:52:19 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E4261108
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 10:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97E4261108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D55283C75DE
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 11:52:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 631F13C7319
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 11:52:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F02A71400C5D
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 11:52:05 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3C3F5217BA;
 Fri,  5 Nov 2021 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636109525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F2PySXksIzzWNWi8Kh0byc4IKojC54gJgbXytDtYuKQ=;
 b=pq/6gzb+WN27tP52mDRNGR+vGVNx4H9oNuacp9rjZ7Ex7z4ME0gqJjhxqnqdjipHWM+3vY
 8JmYEgL1W2u51javLfkrEBcEROwImJVW6iFJ6VfKQo2tVTfMEpp3zp+4wJdcBy9gFHDFJ5
 Aey13aP6LhbHWdYbeiw8VNeFRyzL7CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636109525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F2PySXksIzzWNWi8Kh0byc4IKojC54gJgbXytDtYuKQ=;
 b=fiFU9Tm0xLwt22NrtM6rr1IcR5b3HrFp8rMqJu2acpN8MXBlJ/l1uAEHsw3fjb/0BJV2WJ
 1KZfcylVWgPUfMCQ==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F1301A3B8F;
 Fri,  5 Nov 2021 10:52:03 +0000 (UTC)
References: <20210224165045.17738-1-chrubis@suse.cz>
 <BYAPR13MB2503F63EE761C8A8FC98E3DDFD9D9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <YDzWxnjM3NmXnhTY@yuki.lan>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 05 Nov 2021 10:30:04 +0000
In-reply-to: <YDzWxnjM3NmXnhTY@yuki.lan>
Message-ID: <87a6ii98of.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 0/5] Another attempt at
 hardware discovery
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
Reply-To: rpalethorpe@suse.de
Cc: ceh@ti.com, michals@xilinx.com, automated-testing@yoctoproject.org,
 orsonzhai@gmail.com, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello All,

"Cyril Hrubis" <chrubis@suse.cz> writes:

> Hi!
>> > * Test that needs particular hardware sets the needs_hardware filed in
>> >   the test test structure. This is a free form string, in the uart
>> >   example it's called 'UART-loopback'. If we ever add a test for i2c
>> >   eeprom it would be probably called 'I2C-eeprom', etc.
>> 
>> Sounds good.  It will be good to standardize on these strings
>> in the long run.  For now, just picking strings and trying to reconcile
>> them later seems OK.
>
> That's what I'm expecting there as well.
>
>> > 
>> > * The test library takes this and passes it to the hardware discovery
>> >   script/binary.
>> 
>> This is probably in the patch set, but how is this invoked?
>> Does the script have a well-known name or location?
>
> There is a fallback to a well-known location that can be overrided with
> an environment varible. This is not well designed at this point, I just
> wrote a minimal amount of code for the prototype to run.
>
>> > The example script that is included in this patchset
>> >   just hardcodes configuration for a usb-to-serial cable. In real world
>> >   lab this would be either prepared for each board specifically and
>> >   injected to the filesystem before the test happens, or may be a simple
>> >   script that calls curl with a request to a lab sever, etc.
>> 
>> Either of these seem like workable approaches.  In the case of
>> injecting it into the filesystem, do you have any
>> ideas where you would inject these?  For example,
>> would they go somewhere under /etc, or in /usr/test/conf?
>
> No idea, so far my patchset just puts it into $LTPROOT, but I guess that
> /usr/test/ would be much better place. Do we have a proposal for the
> /usr/test/ hierarchy somewhere?
>
>> Is this something that only the hardware discovery program
>> needs to know?  Or do tests use this data directly?
>
> Currently it's used by the LTP test library, so it's executed by the
> test binary before it forks a child that actually runs the test.
>
> In the future it could be executed by the test driver (e.g. replacement
> for ltp-pan I'm working on), which could then pass the pieces of the
> JSON that describe the hardware to the test for each test invocation.
> This is still under development, but I do not think that these details
> matter at all, what we need at this point is to describe generic enough
> information flow.
>
>> This seems like a rendezvous point between
>> the hardware discovery program and the lab management
>> system, so IMHO it should be well-defined.
>
> Couldn't agree more.
>
>> > 
>> > * The output from the script is a JSON object. If there is a need to
>> >   reconfigure lab hardware before the test, the JSON contains a path to
>> >   a script/binary that has to be called to do so.
>> 
>> That's interesting.
>> 
>> > Again this may be a
>> >   script that calls curl with a request to a lab sever which would, for
>> >   example, interconnect different serial ports with relays.
>> > 
>> >   The parameter to that script is an unique ID for the hardware
>> >   configuration that is listed in each hardware configuration in the
>> >   hwconfs array of objects that follows.
>> > 
>> >   I'm not sure if this actually belongs there, maybe it would be
>> >   cleaner to have one reconfigure script for the whole LTP and we would
>> >   pass the needs_hardware content as well as the unique ID, e.g.
>> > 
>> >   'hardware-reconfigure.sh UART-loopback ttyUSB0-ttyS0'
>> > 
>> >   but that is a minor detail that could be easily sorted out later.
>> > 
>> > 
>> >   The most important part of the JSON is the hwconfs array, which
>> >   consists of hardware description objects, which, apart form the uid,
>> >   are not interpreted by the library, but rather passed to the test. The
>> >   test library loops over the array and forks a testrun for each entry
>> >   in the array.
>> > 
>> >   Each iteration of the test then gets it's parameters as a JSON object.
>> >   In the case of the UART one of the objects in the array looks like:
>> > 
>> >   {
>> >     "uid": "ttyUSB0-ttyUSB0-01",
>> >     "rx": "ttyUSB0",
>> >     "tx": "ttyUSB0",
>> >     "hwflow": 0,
>> >     "baud_rates": [
>> >      9600,
>> >      19200
>> >     ]
>> >   }
>> > 
>> >   Which is mostly self-explanatory, the test then parses the structure
>> >   and executes one test per each baud rate.
>> > 
>> >   What is still missing is the ability to pass the JSON hardware
>> >   description directly to the test, so that we can execute the test
>> >   manually, but that would be fairly easy to add.
>> 
>> OK - let me describe what I had in mind for a test where the serial
>> port was not in loopback mode, to see how it relates to the proposed
>> architecture.  The gpio version of this is implemented in the board
>> farm REST API, but the serial port testing version of this is still
>> under consideration:
>> 
>> Here's how the test would work, for a serial port transmission test where
>> the transmitting side of the serial line was on the DUT and the other side was
>> managed by the lab hardware:
>>  - 1) the test discovers the hardware for DUT endpoint of the serial line
>>     using the hardware discovery program
>>  - 2) the test discovers the hardware for the lab endpoint (receiving end)
>>     of the serial line using the hardware discovery program
>>  - 3) the test discovers the available baud rates from the hardware discovery
>>     program
>>  - 4) the test configures the lab endpoint for reception
>>  - 5) the test configures the DUT endpoint for transmission
>>  - 6) the test loops over the baud rate values, doing the following (7-13):
>>     - 7) use a curl interface or local program to set the receive baud rate of the lab endpoint
>>     - 8) use a curl interface or local program to request serial capture of the lab endpoint
>>     - 9) configure the baud rate of the DUT endpoint
>>     - 10) send data through the DUT endpoint
>>     - 11) use a curl interface or local program to cause the lab endpoint to stop capturing data
>>     - 12) use a curl interface or local program to request the capture data from the lab endpoint
>>     - 13) compare data that was received with the data that was intended to be transmitted
>> 
>> These roles could also be reversed (ie, have the lab endpoint be the sender
>> and the DUT endpoint be the receiver).
>> 
>> The process of configuring the baud rate seems like it corresponds
>> with the hardware_reconfigure.sh script.  But maybe you were only
>> thinking of have this actually set up physical connections, and not
>> manage connection/bus settings.
>> 
>> In any event, maybe the hardware_reconfigure.sh script could know
>> about 'start data capture', 'stop data capture', and 'get captured data'
>> operations, or maybe this should be a separate script.
>>
>> This is structured in a generic way, because I think different tests
>> (such as audio testing, video testing, power measurement testing,
>> CAN bus testing, i2C testing, gpio testing, etc. can all be fit into this
>> model of testing by:
>>   discovering bus endpoints, configuring bus parameters,
>>   transmitting or generating data, capturing data
>>   comparing data
>
> I guess that we need two more generic scripts in the format then, one
> called before the test starts and one called after the test has
> finished.
>
> So something as:
>
> {
>   "pre_test": "/path/to/pre_script.sh",
>   "post_test": "/path/to/post_script.sh",
>   "hwconfs": [
>     ...
>   ]
> }

How about we allow an arbitrary list of callbacks for the initial
implementation?

e.g.

{
  "cmds" : {
    "activate-robot-1": "robocmd 1",
    "launch-missiles": "echo 'fire!' > /dev/stty1",
    ...
  }
  "hwconfs": [ ... ]
}

As we add tests it may turn out there are only a limited number of
callbacks practically possible. Then we can standardise on those.

>
> And these scripts would need to actually be called before each test and
> get JSON as a parameter as well.
>
> e.g. for a serial port described as:
>
> {
>   "uid": "ttyUSB0-ttyUSB0-01",
>   "rx": "ttyUSB0",
>   "tx": "ttyUSB0",
>   "hwflow": 0,
>   "baud_rates": [
>    9600,
>    19200
>   ]
> }
>
> We would get following:
>
> ------------------------------
>
> * pre_script.sh gets passed following JSON:
>
> {
>   "uid": "ttyUSB0-ttyUSB0-01",
>   "rx": "ttyUSB0",
>   "tx": "ttyUSB0",
>   "hwflow": 0,
>   "baud_rate": 9600
> }
>
> * test is executed
>
> * post_script.sh gets passed following JSON
>
> {
>   "uid": "ttyUSB0-ttyUSB0-01",
> }
>
> ------------------------------
>
> * pre_script.sh gets passed following JSON
>
> {
>   "uid": "ttyUSB0-ttyUSB0-01",
>   "rx": "ttyUSB0",
>   "tx": "ttyUSB0",
>   "hwflow": 0,
>   "baud_rate": 19200
> }
>
> * test is executed
>
> * post_script.sh gets passed following JSON
>
> {
>   "uid": "ttyUSB0-ttyUSB0-01",
> }
>
> ------------------------------
>
> This changes things a bit, this means that the pre_script has to be
> executed before each test execution and it's actually passed a JSON data
> rather than simple value. So the test would need to serialize the data
> and send the request instead.
>
> The question is how should we propagate data to the test from a
> post_script.sh. I guess that the output should be JSON as well and in a
> case of binary data it should include a path to a file, since binary
> does not work well for JSON.
>
> So in the case of UART capture test the output from post_script.sh would
> be something as:
>
> {
> 	"capture": "/path/to/capture/file.bin"
> }

Yes, or base64 encode it if the data is small. Or send

{ ...., "trailing_binary": 1 }\n

Then transmit the binary data after the '}\n'

>
> Also in a case that we want the lab to send some binary data to the UART
> during the test the pre_script.sh would get something as:
>
> {
>   "uid": "ttyUSB0-ttyUSB0-01",
>   "hwflow": 0,
>   "baud_rate": 19200,
>   "transmit": "/path/to/transmit/file.bin"
> }
>
> However this means that the test needs to listen even before we call
> this script, which again complicates things a bit.

Not if we make the cmds free form. Using JSON makes perfect sense
IMO. I'd like to combine efforts here and use the JSON parser for the
parallel test executor IPC.

>
>> So far, I don't see anything in LTP proposal that precludes this model of testing.
>> There may be more to add - either extending hardware_reconfigure.sh
>> or adding a new command that a test would use interactively to
>> cause data to be exchanged and allow it to be compared.
>
> Indeed, this is hard to desing especially since I do have very limited
> set of usecases at the moment. But at least your UART case helped a lot,
> thanks!


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
