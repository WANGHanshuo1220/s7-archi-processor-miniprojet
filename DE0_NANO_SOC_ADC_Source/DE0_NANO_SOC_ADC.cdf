/* Quartus Prime Version 17.0.0 Build 595 04/25/2017 SJ Lite Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(SOCVHPS) MfrSpec(OpMask(0));
	P ActionCode(Cfg)
		Device PartName(5CSEMA4U23) Path("D:/S7/archi_de_processeur/mini_projet/DE0_NANO_SOC_ADC_Source/") File("DE0_NANO_SOC_ADC_time_limited.sof") MfrSpec(OpMask(1));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
